/**
 * Created by new on 24.05.2017.
 */
({
    jsLoaded: function (component, event, helper) {

        setTimeout(function () {
            // var map = L.map('map', {zoomControl: false}).setView([37.784173, -122.401557], 14);
            var map = L.map('map', {zoomControl: true}).setView([53.8482145, 27.6393256], 2);
            L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
                {
                    attribution: 'Tiles © Esri'
                }).addTo(map);
            component.set("v.map", map);
        });
    },


    addressLoaded: function (component, event, helper) {
        // Add m
        // if (component.get('v.map') != null) {
        //     // component.get('v.map').remove();
        //     // component
        //     component.set('v.map', []);
        // }
        // var map = L.map('map', {zoomControl: true}).setView([53.8482145, 27.6393256], 2);
        // L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
        //     {
        //         attribution: 'Tiles © Esri'
        //     }).addTo(map);
        // component.set("v.map", map);

        var map = component.get('v.map');
        var addresses = event.getParam('addresses');
        var marker = [];
        for (var i = 0; i < addresses.wrapperInners.length; i++) {
            var address = addresses.wrapperInners[i];
            var latLng = [address.lat, address.lng];
            // marker[i] = new L.marker(latLng);
            // // alert(latLng);
            // marker[i].on('onclick',onClick());

            // marker[i].bindPopup("hello bitches").openPopup().addTo(map);
            L.marker(latLng).bindPopup("I am a polygon.").addTo(map);
            // L.marker([53.8482145, 27.6393256]).addTo(map);

            // L.marker([53.8482145,27.6393256]).addTo(map);
        }
        var event = event.getParam("address");
        function onClick() {
            alert('Hi');
        }
    },
    addressSelected: function (component, event, helper) {
        // Center the map on the account selected in the list
        alert('Selected from map');
        debugger;
        var map = component.get('v.map');

        // alert(event.getParam());
        alert(event.getParam("address"));
        var address = event.getParam("address");
        // alert(address.lat + '  ' + address.lng);
        function onClick(e) {
            alert(address.lat + ' between ' + address.lng);
        }

        map.on('click', onClick());
        map.panTo([address.lat, address.lng]);
    },
    // accountsLoaded: function(component, event, helper) {
    //
    //     // Add markers
    //     var map = component.get('v.map');
    //     var accounts = event.getParam('accounts');
    //     for (var i=0; i<accounts.length; i++) {
    //         var account = accounts[i];
    //         // var latLng = [account.Location__Latitude__s, account.Location__Longitude__s];
    //         var latLng = [account.Location__Latitude__s, account.Location__Longitude__s];
    //         alert(latLng)
    //         L.marker(latLng, {account : account}).addTo(map);
    //         // L.marker([53.8482145, 27.6393256]).addTo(map);
    //
    //         // L.marker([53.8482145,27.6393256]).addTo(map);
    //     }
    // },
    // accountSelected: function(component, event, helper) {
    //     // Center the map on the account selected in the list
    //     var map = component.get('v.map');
    //     var account = event.getParam("account");
    //     map.panTo([account.Location__Latitude__s, account.Location__Longitude__s]);
    // }
    initMap: function () {
        var myLatlng = {lat: -25.363, lng: 131.044};

        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 4,
            center: myLatlng
        });

        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: 'Click to zoom'
        });

        map.addListener('center_changed', function () {
            // 3 seconds after the center of the map has changed, pan back to the
            // marker.
            window.setTimeout(function () {
                map.panTo(marker.getPosition());
            }, 3000);
        });

        marker.addListener('click', function () {
            map.setZoom(8);
            map.setCenter(marker.getPosition());
        });
    }
})