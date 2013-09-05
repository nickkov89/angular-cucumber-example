portal.controller 'MeCtrl', ($scope, Me) ->
  $scope.me = Me.get()
