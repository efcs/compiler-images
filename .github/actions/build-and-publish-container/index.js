const core = require('@actions/core');
const github = require('@actions/github');
const exec = require('@actions/exec');

const { execSync } = require('child_process');
const { spawn, spawnSync } = require('child_process');
const path = require('path');
const fs = require('fs');
const process = require('process');

function run_command(cmd) {
  var p;
  console.log(`${cmd}`)
  execSync(cmd, (error, stdout, stderr) => {
    console.log(`${stdout}`);
    console.error(`${stderr}`);
    if (error) {
      process.exit(error.code);
    }
  });
  return null;
}

function run_command_async(cmd) {
  p = spawn(cmd, { shell : true});

  p.stdout.on('data', (data) => {
    process.stdout.write(data.toString());
  });

  p.stderr.on('data', (data) => {
    process.stderr.write(data.toString());
  });

  p.on('error', (code) => {
    process.exit(code);
  });

  return p
}

async function authenticate_registry() {
  try {
    // `who-to-greet` input defined in action metadata file
    const token = core.getInput('token');
    core.setSecret(token)

    const registry = core.getInput('registry');
    const user = core.getInput('user');
    console.log('Authenticating as ${user} for registry ${registry}')

    console.log(`Hello ${nameToGreet}!`);
    exec.exec('docker')

  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
