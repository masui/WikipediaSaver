require 'osx/cocoa'
include OSX

require_framework 'ScreenSaver'
require_framework 'Webkit'

class WikipediaSaver < ScreenSaverView
  def initWithFrame_isPreview(frameRect,p)
    super_initWithFrame_isPreview(frameRect,p)
  end

  def animateOneFrame
    @webView.mainFrame.loadRequest(@request)
  end

  def animationTimeInterval
    15
  end

  def setSaver(saver)
    @saver = saver
    setup
  end

  def setup
    url = "http://ja.wikipedia.org/wiki/%E7%89%B9%E5%88%A5:Random"
    @nsurl = NSURL.URLWithString(url)

    screenRect = NSScreen.mainScreen.frame
    @webView = WebView.alloc.initWithFrame(screenRect)
    @saver.addSubview(@webView)

    @request = NSURLRequest.requestWithURL(@nsurl)
    @webView.mainFrame.loadRequest(@request)
  end
end
