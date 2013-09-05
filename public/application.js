var portal;

portal = angular.module('crowdtap.portal', ['ngResource']);

portal.controller('BrandsCtrl', function($scope, Brand) {
  return $scope.brands = Brand.query(function() {
    return $scope.brands.totalActions = function() {
      var brand, total, _i, _len, _ref;
      total = 0;
      _ref = $scope.brands;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        brand = _ref[_i];
        total += brand.actions_count;
      }
      return total * $scope.brands.length;
    };
  });
});

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

portal.factory('Brand', function($resource) {
  return $resource('/api/v2/brands/');
});

portal.factory('Me', function($resource) {
  return $resource('/api/v2/me');
});
