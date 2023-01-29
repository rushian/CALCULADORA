// Requires the webdriverio client library
// (npm install webdriverio)
// Then paste this into a .js file and run with Node:
// node <file>.js

const wdio = require('webdriverio');
async function main () {
  const caps = {"platformName":"Android","appium:automationName":"uiautomator2","appium:deviceName":"emulator-5554","appium:appPackage":"com.google.android.calculator","appium:appActivity":"com.android.calculator2.Calculator","appium:avd":"nexus10","appium:deviceOrientation":"portrait","appium:ensureWebviewsHavePages":true,"appium:nativeWebScreenshot":true,"appium:newCommandTimeout":3600,"appium:connectHardwareKeyboard":true}
  const driver = await wdio.remote({
    protocol: "http",
    hostname: "127.0.0.1",
    port: 4723,
    path: "/wd/hub",
    capabilities: caps
  });
  let el1 = await driver.$("~8");
  await el1.click();
  await driver.deleteSession();
}

main().catch(console.log);