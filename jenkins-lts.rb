class JenkinsLts < Formula
  homepage "http://jenkins-ci.org/#stable"
  url "http://mirrors.jenkins-ci.org/war-stable/1.609.2/jenkins.war"
  sha256 "60e775b1d5df417370a1768496fa3ccc9d17f9a093bf87f543765f9d4e401578"

  depends_on :java => "1.6+"

  conflicts_with "jenkins",
    :because => "both use the same data directory: $HOME/.jenkins"

  def install
    system "jar", "xvf", "jenkins.war"
    libexec.install Dir["jenkins.war", "WEB-INF/jenkins-cli.jar"]
    bin.write_jar_script libexec/"jenkins.war", "jenkins-lts"
    bin.write_jar_script libexec/"jenkins-cli.jar", "jenkins-lts-cli"
  end

  plist_options :manual => "jenkins-lts"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>/usr/bin/java</string>
          <string>-Dmail.smtp.starttls.enable=true</string>
          <string>-jar</string>
          <string>#{opt_prefix}/libexec/jenkins.war</string>
          <string>--httpListenAddress=127.0.0.1</string>
          <string>--httpPort=8080</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
    EOS
  end

  def caveats; <<-EOS.undent
    Note: When using launchctl the port will be 8080.
    EOS
  end
end
