#!/usr/bin/env bash

expected_checksum="0e96ee023407ba4779f7851f8cf3d2fb"
file_name="OCPP_1.6_documentation_2019_12-2.zip"

rm -rf spec.d definitions
rm -rf "$file_name"

if [ ! -f "$file_name" ]; then
  curl -s -o $file_name https://openchargealliance.org/wp-content/uploads/2023/11/OCPP_1.6_documentation_2019_12-2.zip
fi

calculated_checksum=$(md5sum "$file_name" | awk '{ print $1 }')

if [ "$calculated_checksum" != "$expected_checksum" ]; then
  echo "Something change in the OCPP oficial Documentation"
  exit 0
fi

unzip -o "$file_name"
mv OCPP_1.6_documentation_2019_12 spec.d

rm "$file_name"

mkdir -p definitions/1.6/

mv spec.d/schemas/json/* definitions/1.6/
rm definitions/1.6/OCPP-1.6-JSON-Schemas.zip