#!/bin/sh -l

export PATH="/home/node/.npm-global/bin:$PATH"

if [ -z "$INPUT_APIKEY" ]; then
  echo "apiKey is required"
  exit 1
fi

export FLEEK_API_KEY=$INPUT_APIKEY

# Parse flags
flags=""
if [ -n "${INPUT_COMMITHASH}" ]; then
  echo "Deploying Commit ${INPUT_COMMITHASH}"
  flags=" $flags--hash=${INPUT_COMMITHASH}"
fi

# Set correct directory
cd /github/workspace || exit
if [ -n "${INPUT_WORKDIR}" ]; then
  cd "${INPUT_WORKDIR}" || exit
  echo "Changed to working directory: $(pwd)"
fi

echo "Executing sites deploy"
output=$(fleek site:deploy"$flags" 2>&1)
if [ $? -ne 0 ]; then
  echo "$output"
  echo "Site deployment failed"
  exit 1
fi

# Export outputs
echo "$output"
deployUrl=$(echo "$output" | grep -Eo 'https://[^ >]+' | head -1)
echo "::set-output name=deployUrl::$deployUrl"
