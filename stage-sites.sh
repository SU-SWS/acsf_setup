#!/bin/bash
source ~/.bashrc
curl 'https://www.cardinalsites.acsitefactory.com/api/v2/stage' \
  -X POST -H 'Content-Type: application/json' \
  -d '{"to_env": "test",
  "sites": [10386,9996,21996,10291,12791,9931,10381,10436,19271,10441,10446,9956,10226,10426,10676,16621,17387,19321,16136,19006,25016,9956,17676,17281,16471,19456,8011,16871,16901,16881,16891,16876,6886,16236,13831,16796,16871,20986,16876,16901,16891,19236,16881,19691,20491,10696,16611,21996,22001,17671,17666,16611,17091,20246,21976,17446,21736,21661,20391,22181,17151,21476,20241,17451,15721,20396,1576,6196,16071,22051,21976,20391,20621,19786,19286,20686,22316,20146,19806,19341,10071,17387,17096,22231,16316,20191,21416,19146,15891,9971,19686,10936,9331,17086,16816,5951,5961,16456,17081,17091,17101,17106,17111,17116,20286,23756,20111,20746,23586,22051,18316,13751,21551,22311,21546,21301,21706,25076,22191,23876,22106,24211,20396,23826,25661,21481,24136,26061,26436,22146,24866,24391,24036,26531,26176,19171,18956,24211,16801,15706,10356,25786,24991,10131,23501,23281,23251,25611,23816,10206,22576,9946,10196,25081,22001,23416,17671,15291,15831,17786,21681,18931,19816,19811,19821,19831,19836,19826,19841,21811,21451,22206,24661,26066],
  "wipe_target_environment": false,
  "synchronize_all_users": false,
  "detailed_status": false}' \
  -v -u "$ACSF_USERNAME":"$ACSF_API_KEY"
