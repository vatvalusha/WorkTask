/**
 * Created by valeriyartemenko on 17.05.17.
 */

public with sharing class WrapperLocation {

    @AuraEnabled
    public List<String> adresses {
        get;
        set;
    }
    @AuraEnabled
    public String resultParse {
        get;
        set;
    }
    @AuraEnabled
    public Boolean flag {
        get;
        set;
    }

    public WrapperLocation(List<String> addresses, String resultParse, Boolean flag) {
        this.adresses = addresses;
        this.resultParse = resultParse;
        this.flag = flag;
    }


    public override String toString() {
        return 'adresses:' + this.getListAdress() +
                'resultParse: ' + this.resultParse + '\n' +
                'flag: ' + this.flag;

    }


    public String getListAdress() {
        String massAdress;
        if (this.adresses == null) return null;
        for (String s : this.adresses) {
            massAdress = massAdress + ' ' + s + '\n';
        }
        return massAdress;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof WrapperLocation) {
            WrapperLocation p = (WrapperLocation)obj;
            return ((adresses==p.adresses) && (resultParse==p.resultParse) && (flag == p.flag));
        }
        return false;
    }

    public override Integer hashCode() {
        Integer result = adresses != null ? adresses.hashCode() : 0;
        result = 31 * result + (resultParse != null ? resultParse.hashCode() : 0);
        result = 31 * result + (flag != null ? 1 : 0);
        return result;
    }
}