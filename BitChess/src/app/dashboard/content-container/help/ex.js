/**
 * Created by Tamara on 23.04.2017.
 */
angular.module('anchorScrollExample', [])
  .controller('ScrollController', ['$scope', '$location', '$anchorScroll',
    function($scope, $location, $anchorScroll) {
      $scope.gotoBottom = function() {
        // set the location.hash to the id of
        // the element you wish to scroll to.
        $location.hash('bottom');

        // call $anchorScroll()
        $anchorScroll();
      };
    }]);
