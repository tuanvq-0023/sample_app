module UsersHelper
  def gravatar_for user, options = {size: Settings.default_gravatar_size}
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    size = options.nil? ? Settings.default_gravatar_size : options[:size]
    gravatar_url =
      Settings.default_gravatar_url + gravatar_id.to_s + "?s=" + size.to_s
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
