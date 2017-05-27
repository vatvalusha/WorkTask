/**
 * Created by valeriyartemenko on 17.05.17.
 */

public with sharing class WrapperLocation {


    @AuraEnabled
    public WrapperInner[] wrapperInners{
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


    public WrapperLocation(WrapperInner[] wrapperInners, String resultParse, Boolean flag) {
        this.wrapperInners = wrapperInners;
        this.resultParse = resultParse;
        this.flag = flag;
    }


    public override String toString() {
        return 'wrapperInners:' + this.wrapperInners +
                'resultParse: ' + this.resultParse + '\n' +
                'flag: ' + this.flag;

    }


//    public String getListAdress() {
//        String massAdress;
//        if (this.adresses == null) return null;
//        for (String s : this.adresses) {
//            massAdress = massAdress + ' ' + s + '\n';
//        }
//        return massAdress;
//    }


}