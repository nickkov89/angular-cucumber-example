portal.controller 'BrandsCtrl', ($scope, Brand) ->
  $scope.brands = Brand.query ->
    $scope.brands.totalActions = ->
      total = 0
      for brand in $scope.brands
        total += brand.actions_count
      total * $scope.brands.length
