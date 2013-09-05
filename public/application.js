var portal;

portal = angular.module('crowdtap.portal', ['ngResource']);

portal.controller('MeCtrl', function($scope, Me) {
  return $scope.me = Me.get();
});

portal.filter('firstLetter', function() {
  return function(input) {
    if (input) {
      return "" + input[0] + ".";
    }
  };
});

portal.factory('Me', function($resource) {
  return $resource('/api/v2/me');
});
