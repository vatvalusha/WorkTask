/**
 * Created by valeriyartemenko on 19.05.17.
 */
//
//@IsTest
//global class MockHttpResponseGenerator implements HttpCalloutMock {
//    global HTTPResponse respond(HTTPRequest req) {
//
//        System.assertEquals('https://maps.googleapis.com/maps/api/geocode/json?address=hfhfgdgdg&key=AIzaSyDsqLq3L8ZHbnH10kr_lPD6IG_ZXjJh6MI', req.getEndpoint());
//        System.assertEquals('GET', req.getMethod());
//
//        HttpResponse res = new HttpResponse();
//        res.setHeader('Content-Type', 'application/json');
//        res.setBody('{"results": [],"status": "ZERO_RESULTS"}');
//        res.setStatusCode(200);
//        return res;
//    }
//}
@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {

    private String address;
    private String viewString;

    public MockHttpResponseGenerator(String address, String viewString) {
        this.address = address;
        this.viewString = viewString;

    }

    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('https://maps.googleapis.com/maps/api/geocode/json?address=' + address + '&key=AIzaSyDsqLq3L8ZHbnH10kr_lPD6IG_ZXjJh6MI', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(viewString);
        res.setStatusCode(200);
        return res;
    }
}
