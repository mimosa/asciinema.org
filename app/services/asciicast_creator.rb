class AsciicastCreator

  def create(attributes, udid, username)
    user = User.for_udid!(udid, username)
    attributes = attributes.merge(user: user)
    ap attributes
    puts '_'*88
    asciicast = Asciicast.create!(attributes)
    AsciicastWorker.perform_async(asciicast.id)

    asciicast
  end

end
