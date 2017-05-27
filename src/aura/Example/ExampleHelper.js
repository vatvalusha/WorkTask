({
	render : function(cmp, helper) {
    	var ret = this.superRender();
        window.alert("I get called");
    	return ret;
	},
    rerender : function(cmp, helper){
    	this.superRerender();
        window.alert("I do not get called :(");
        helper.paintCustomSvg();
	},
})