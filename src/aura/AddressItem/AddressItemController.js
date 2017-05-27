/**
 * Created by new on 24.05.2017.
 */
({
    addressSelected : function(component) {
        alert('selected From item');
        var event = $A.get("e.c:AddressSelected");
        // alert(event.getParam("address"));
        event.setParams({"address": component.get("v.address")});
        // alert(event.getParam("address"));
        event.fire();
    }
})