({
    "save": function (component, event) {
        var jopa;
        var action = component.get("c.saveAdress");

        action.setParams({"adress": component.get("v.AccountAdress"), "id": component.get("v.recordId")});

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // debugger;
                jopa = response.getReturnValue();
                component.set("v.wrapper", jopa);
                component.set("v.Flag", jopa.flag);

                if (component.get("v.Flag") == true) {
                    alert("Redirect");
                    window.location.href = '/' + component.get("v.recordId");
                    // this.navigateFunction(component);
                }
                if (jopa.wrapperInners.length > 0) {
                    component.set("v.menuAddress", true);
                }
                if (jopa.wrapperInners.length == 0) {
                    component.set("v.menuAddress", false);
                }
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                            errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
            var event = $A.get("e.c:AddressLoaded");
            event.setParams({"addresses": jopa});
            event.fire();
        });

        $A.enqueueAction(action);
    },

    navigate: function (component) {
        alert("Hello i am function ");
    },

    doInit: function (cmp) {
        var attributeValue = cmp.get("c.currentAdress");
        attributeValue.setParams({"id": cmp.get("v.recordId")});
        attributeValue.setCallback(this, function (response) {
            var stringResult = response.getReturnValue();
            cmp.set("v.AccountAdress", stringResult);
        });
        $A.enqueueAction(attributeValue);
    },
    Update: function (component, event, helper) {
        component.set('v.Flag', true);
    },
    showCaseDeleteModal: function (component, eventc, helper) {
        alert('from showCase');
        var event = $A.get("e.c:AddressSelected");
        // event.setParams({"address": component.get("v.addressInner")});
        alert(eventc.target.id);
        var fff =  eventc.target.id;
        alert(event.getParam("address"));
        // event.setParams({"address": component.get('v.addressInner')});
        event.setParams({"address": eventc.target.id.lat});
        alert(event.getParam("address"));
        event.fire();
        // var idx = event.target.id;
        // var action = component.get("c.changeAddress");
        // action.setParams({"address": idx, "id": component.get("v.recordId")});
        // window.location.href = '/' + component.get("v.recordId");
        // $A.enqueueAction(action);


    },
    counter:function (component) {
        var counter = 1;
        return counter++;
        // $A.enqueueAction(counter);
    }
})
function navigateFunction(component) {
    alert("Hello i am function ");
}