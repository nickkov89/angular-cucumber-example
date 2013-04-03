module.exports = exports = {}

exports.assets_path = (asset) ->
  url = []
  url.push Spine.env.assetPrefixUrl
  url.push Spine.assets_version if Spine.env.hashAssets && Spine.assets_version?
  url.push 'crowdtap.portal'
  url.push if asset.charAt(asset.length - 1) is '/' then asset.substring(0, str.length - 1) else asset
  url.join('/')
