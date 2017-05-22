public class GetAdress {


    public static ID accId { get; set; }
    public static List<Object> possibleAdress { get; set; }
    public HttpResponse response;


    public GetAdress() {
//         response = getResponse(adress);
    }

    //Cover
    @AuraEnabled
    public static String currentAdress(ID id) {
        List<Account> allAccounts = [Select ID, Name, MyAdress__c From Account Where id = :id];
        for (Account acc : allAccounts) {
            if (acc.id == id && acc.MyAdress__c != null) {
                return acc.MyAdress__c;
            }
        }
        return null;
    }
    @AuraEnabled
    public static void changeAddress(String address, ID id) {
        List<Account> account = [Select ID, Name, MyAdress__c From Account Where ID = :id];
        for (Account acc : account) {
            acc.MyAdress__c = address;
        }
        upsert account;
    }

    //Cover
    public static Integer sumInteger(Integer a, Integer b) {
        return a + b;
    }


    @AuraEnabled
    public static WrapperLocation saveAdress(String adress, Id id) {
        List<Account> account = [Select ID, Name From Account Where ID = :id];
        HttpResponse response = getResponse(adress);
        WrapperLocation wrapperLocation = JSONparser(adress);
        for (Account acc : account) {
            acc.MyAdress__c = adress;
        }
        if (wrapperLocation.resultParse == 'true') {
            update account;
            return wrapperLocation;
        } else if (wrapperLocation.resultParse == 'false') {
            System.debug('Iside false');
            System.debug('LIST: ' + wrapperLocation.toString());
            wrapperLocation.resultParse = 'Current address do not exist';
            return wrapperLocation;
        } else if (wrapperLocation.resultParse == 'mistake') {
            System.debug('Iside Mistake');
            wrapperLocation.resultParse = 'We have mistake in address';
            return wrapperLocation;

        }
        return null;
    }

    //Cover
    public static HttpResponse getResponse(String addresse) {
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?address=' + addresse + '&key=AIzaSyDsqLq3L8ZHbnH10kr_lPD6IG_ZXjJh6MI';
        request.setEndPoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        return response;
    }

    public static JSONParser getParser(HttpResponse response) {
        JSONParser parser = JSON.createParser(response.getBody());
        System.debug(response.getBody());
        return parser;
    }

    //Cover
    public static List<String> listFormattedAdress(JSONParser parser) {
        List<String> formattedAress = new List<String>();
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'formatted_address')) {
                parser.nextToken();
                formattedAress.add(parser.getText());
            }
        }
        return formattedAress;
    }

    //Cover
    public static WrapperLocation JSONParser(String address) {
        HttpResponse response = getResponse(address);
        JSONParser parser = getParser(response);
        List<String> listAddress = listFormattedAdress(getParser(response));
        System.debug('ListAddresse:' + listAddress);
        if (!testAdress(address)) {
            return new WrapperLocation(null, 'mistake', false);
        }
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'status')) {
                    parser.nextToken();
                    if (parser.getText() == 'ZERO_RESULTS') {
                        System.debug('Inside status');
//                        System.debug()
                        return new WrapperLocation(new List<String>(), 'false', false);
                    }
                }
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                        (parser.getText() == 'partial_match')) {
                    parser.nextToken();
                    if (parser.getBooleanValue()) {
                        System.debug('Inside partial_match');
                        System.debug('List:' + listAddress);

                        return new WrapperLocation(listAddress, 'mistake', false);
                    }
                }
            }
        System.debug('True');
        return new WrapperLocation(null, 'true', true);
    }

    public static Boolean testAdress(String address) {
        String[] testAdress = address.split(',');
        if(testAdress.size()<=1) return true;
        Pattern p = Pattern.compile('^[0-9].*$');
        Matcher m = p.matcher(testAdress[testAdress.size() - 1]);
        if (m.matches()) {
            return true;
        } else return false;
    }
}
