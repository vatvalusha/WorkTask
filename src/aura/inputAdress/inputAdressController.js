({
    "save": function (component, event) {
        var jopa;
        var action = component.get("c.saveAdress");

        // this.navigate(component);
        // function call(component) {
        //     var action = component.get("c.getResponse");
        //     action.setParams({"adress": component.get("v.AccountAdress")});
        //     action.setCallback(this, function (response) {
        //         var stringResult = response.getReturnValue();
        //         component.set("v.response", stringResult);
        //     });
        //     $A.enqueueAction(action);
        //     return component.get("v.response");
        // }
        // call();
        // var response = call();
        action.setParams({"adress": component.get("v.AccountAdress"), "id": component.get("v.recordId")});

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // debugger;
                jopa = response.getReturnValue();
                component.set("v.Message", jopa.resultParse);
                component.set("v.Flag", jopa.flag);
                // component.set("v.Flag", true);
                component.set("v.ListAddresses", jopa.adresses);
                if (component.get("v.Flag") == true) {
                    alert("Redirect");
                    window.location.href = '/' + component.get("v.recordId");
                    // this.navigateFunction(component);
                }
                if(jopa.adresses.length > 0){
                    component.set("v.menuAddress", true);
                }
                if(jopa.adresses.length == 0){
                    component.set("v.menuAddress", false);

                }

            }

            else if (state === "INCOMPLETE") {
                // do something
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
    showCaseDeleteModal: function (component, event, helper) {
        var idx = event.target.id;
        var action = component.get("c.changeAddress");
        action.setParams({"address": idx, "id": component.get("v.recordId")});
        window.location.href = '/' + component.get("v.recordId");
        $A.enqueueAction(action);


    }
})
function navigateFunction(component) {
    alert("Hello i am function ");
}