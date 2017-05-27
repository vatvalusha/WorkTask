/**
 * Created by valeriyartemenko on 19.05.17.
 */

@IsTest
private class ControllerTestClass {

//    @testSetup static void initAccount(){
//        Id id = '0010Y00000MZec5QAD';
//        Account account = new Account(name = 'TestAccount', MyAdress__c = 'AddressaTest');
//        insert account;
//    }

    static testMethod void testBehavior() {
        System.assertEquals(4, GetAdress.sumInteger(2, 2));
    }

    @isTest static void testCallout() {
        String address = 'Uborovicha';
        HttpResponse res = httpResponse(address, View.resultParse);
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = View.resultParse;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }

    @isTest static void listFormattedAdressTest() {
        String address = 'Uborovicha';
        List<String> expected = new List<String>();
        expected.add('Gornja Borovica, Bosnia and Herzegovina');
        HttpResponse res = httpResponse(address, View.resultParse);
        List<String> actually = GetAdress.listFormattedAdress(GetAdress.getParser(res));
        System.assertEquals(expected, actually);
    }

    @isTest static void JSONParserZeroStatus(){
        String address = 'sdfghgfdsfgh';
        WrapperLocation expected = new WrapperLocation(null, 'false', false);
//        HttpResponse res = httpResponse(address, View.zeroResult);
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(address,View.zeroResult));
        WrapperLocation actually = GetAdress.JSONParser(address);
        System.assertEquals(expected,actually);
    }

    @isTest static void JSONParserPartialMatch(){
        String address = 'Petro34';
//        HttpResponse res = httpResponse(address, View.partialMatch);
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(address,View.partialMatch));
        List<String> listAddress = GetAdress.listFormattedAdress(GetAdress.getParser(GetAdress.getResponse(address)));
        WrapperLocation expected = new WrapperLocation(listAddress, 'mistake', false);
        WrapperLocation actually = GetAdress.JSONParser(address);
        System.assertEquals(expected,actually);
    }

    @isTest static void JSONParserTrue(){
        String address = 'G';
//        HttpResponse res = httpResponse(address, View.trueResult);
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(address,View.trueResult));
        WrapperLocation expected = new WrapperLocation(null, 'true', true);
        WrapperLocation actually = GetAdress.JSONParser(address);
        System.assertEquals(expected,actually);
    }

    //Can't made mock for HttpResponse
    @isTest static void saveAdressTest(){
        String address = 'sdfghgfdsfgh';
        ID id = '0010Y00000MZec5QAD';
        WrapperLocation expected = new WrapperLocation(null, 'Current address do not exist', false);
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(address,View.zeroResult));
        WrapperLocation actually = GetAdress.saveAdress(address,id);
        System.assertEquals(expected,actually);
    }

//    @isTest static  void currentAdressTest(){
//        String nameTest = 'TestAccount';
//        Account account = [Select ID, Name, MyAdress__c From Account Where Name =: nameTest];
//        System.debug(account);
//        String expected = account.MyAdress__c;
//        String actually = GetAdress.currentAdress(account.id);
//        System.assertEquals(expected,actually);
//    }

//    @isTest static void changeAddressTest(){
//        String nameTest = 'TestAccount';
//        String newName = 'NewTestName';
//        Account expected = [Select ID, Name, MyAdress__c From Account Where Name =: nameTest];
//        GetAdress.changeAddress(newName, expected.id);
//        Account actually = [Select ID, Name, MyAdress__c From Account Where Name =: newName];
//        System.assertEquals(expected.id,actually.id);
//
//    }

    public static HttpResponse httpResponse(String address, String view){
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(address,view));
        HttpResponse res = GetAdress.getResponse(address);
        return res;
    }
}