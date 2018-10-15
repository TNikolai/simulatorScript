const exec = require("child_process").exec;

const child = exec("xcrun simctl list runtimes -j", function(
  error,
  stdout,
  stderr
) {
  console.log("stdout: " + stdout);
  console.log("stderr: " + stderr);
  if (error !== null) {
    console.log("exec error: " + error);
  }
});
