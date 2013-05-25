module.exports = exports = {}

exports.assets_path = (asset) ->
  url = []
  url.push PortalApp.env.assetPrefixUrl
  url.push PortalApp.assets_version if PortalApp.env.hashAssets && PortalApp.assets_version?
  url.push 'crowdtap.portal'
  url.push if asset.charAt(asset.length - 1) is '/' then asset.substring(0, str.length - 1) else asset
  url.join('/')
