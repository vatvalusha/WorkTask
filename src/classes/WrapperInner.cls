/**
 * Created by new on 24.05.2017.
 */

public with sharing class WrapperInner {

    @AuraEnabled
    public String adresses {
        get;
        set;
    }

    @AuraEnabled
    public String lat{
        get;
        set;
    }

    @AuraEnabled
    public String lng{
        get;
        set;
    }

    public WrapperInner(String addresses, String lat, String lng) {
        this.adresses = addresses;
        this.lat = lat;
        this.lng = lng;
    }

    public override String toString() {
        return 'address:' + this.adresses + '\n' +
                'latitude: ' + this.lat + '\n' +
                'longitude: ' + this.lng;

    }
}