class ScreenshotWorker
  include Sidekiq::Worker

  def perform(url, slug)
    `/Users/fscott/Personal/projects/webnark/screenshot/make_screenshot.sh "#{url}" > /Users/fscott/Personal/projects/webnark/webnark-rails/public/screenshots/#{slug}.png`
  end
end
