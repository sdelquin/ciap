angular.module "myApp", ["vModal"]

.factory "myModal", (vModal) ->
    return vModal
        controller: "MyModalController"
        controllerAs: "myModalCtrl"
        templateUrl: "/static/templates/my-modal.html"

.controller "MyModalController", (myModal, $scope, $http) ->
    $scope.myModal = myModal
    $scope.email_addr = ""
    $scope.email_subject = ""
    $scope.email_addr_error = false
    $scope.email_subject_error = false
    $scope.send_button_text = "Send!"

    $scope.send_mail = () ->
        if not $scope.email_addr
            $scope.email_addr_error = true
        else
            $scope.email_addr_error = false
            if not $scope.email_subject
                $scope.email_subject_error = true
            else
                $scope.email_subject_error = false
                $scope.send_button_text = "Sending"
                $http.get "/ajax",
                    params:
                        price: angular.element($("#input-price")).val()
                        email_addr: $scope.email_addr
                        email_subject: $scope.email_subject
                .success (data) ->
                    $scope.send_button_text = "Done!"
                    console.log(data)

.controller "AppController", (myModal, $scope) ->
    $scope.myModal = myModal
