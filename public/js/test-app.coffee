portalDev = angular.module 'crowdtap.portalDev', ['crowdtap.portal', 'ngMockE2E']

portalDev.run(($httpBackend) ->
  test = [{test: 1}]
  $httpBackend.whenGET('/api/v2/brands').respond(test)
  $httpBackend.whenGET('/api/v2/me').respond(test)
  $httpBackend.whenGET(/^views\//).passThrough()
)
