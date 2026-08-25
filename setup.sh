#!/bin/bash

# SPDX-License-Identifier: Apache-2.0
# Copyright 2026 Andexor Network, Inc.
# Author: Ed Jenkins<ed@andexor.net>

# Modify and run this to add new dependencies.

# dnspython
# [dnspython](https://www.dnspython.org/)
# [dnspython](https://github.com/rthalley/dnspython)
# [dnspython](https://dnspython.readthedocs.io/en/latest/)

uv --quiet add dnspython
# uv add "dnspython[aioquic]"
# uv add "dnspython[cryptography]"
# uv add "dnspython[httpx]"
uv --quiet add "dnspython[idna]"

# To get a license report, you can use pip-licenses.
# It is not required for the project to run,
# but it is useful for auditing dependencies.
# https://pypi.org/project/pip-licenses/

mkdir -p reports
uv --quiet add pip-licenses
uv --quiet sync
echo " " >> reports/license-report.txt
date --iso-8601 seconds >> reports/license-report.txt
echo " " >> reports/license-report.txt
pip-licenses --format=markdown >> reports/license-report.txt

# Check for known vulnerabilities in dependencies.
echo " " >> reports/uv-audit-report.txt
date --iso-8601 seconds >> reports/uv-audit-report.txt
echo " " >> reports/uv-audit-report.txt
uv --preview-features audit-command audit 2>> reports/uv-audit-report.txt
