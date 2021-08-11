#!/bin/bash
curl 'https://www.cardinalsites.acsitefactory.com/api/v2/stage' \
  -X POST -H 'Content-Type: application/json' \
  -d '{"to_env": "test",
  "sites": [10386,9996,9951,10291,12791,9931,10236,10381,10436,9466,10441,10446,9956,10226,10426,10461,10676,16621,17387,9361,16136,19006,16661,9956,17676,14656,17281,16471,19456,8011,10711,16871,16901,16896,16881,16866,16891,16876,6886,16236,13831,16796,16871,20986,16866,16876,16896,16901,16891,19236,16881,19691,20491,10696,16611,21996,22001,17671,17666],
  "wipe_target_environment": false,
  "synchronize_all_users": false,
  "detailed_status": false}' \
  -v -u "$ACSF_USERNAME":"$ACSF_API_KEY"
