/**
 * Created by new on 23.05.2017.
 */

public with sharing class AccountController {

    @AuraEnabled
    public static List<Account> findAll() {
        return [SELECT id, name, Location__Latitude__s, Location__Longitude__s
        FROM Account
        WHERE Location__Latitude__s != NULL AND Location__Longitude__s != NULL
        LIMIT 50];
    }


    @AuraEnabled
    public static WrapperInner[] listFormattedAdress() {
        String address = 'Pobedi,3';
        HttpResponse response = GetAdress.getResponse(address);
        JSONParser parser = GetAdress.getParser(response);
        WrapperInner[] listAddress = GetAdress.getVariants(GetAdress.getParser(response));
        System.debug('LIST AccController: ' + listAddress);
        return listAddress;
    }

    @AuraEnabled
    public static List<String> listlocation() {
        String address = 'Pobedi,3';
        HttpResponse response = GetAdress.getResponse(address);
        JSONParser parser = GetAdress.getParser(response);
        List<String> location = GetAdress.locationList(GetAdress.getParser(response));
        System.debug('LIST AccController: ' + location);
        return location;
    }

}