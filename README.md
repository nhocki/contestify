Contestify
====

This is a simple ruby gem to automate the process of setting up a programming contest from a [COCI](http://www.hsin.hr/coci/) problem set using [DOMJudge](http://domjudge.sourceforge.net/).

Usage
---

```
  contestify coci_problems_url judge_upload_url judge_password
```

This will get the .zip file from the `coci_problems_url` and add the problems to the DOM Judge on the server. This **will not** create a new contest. Just add problems to the current one.

It is assumed that the admin username is `admin`.

Contributions
---

If you find any bug or have any addition, please let us know. You can use the [issue tracker](https://github.com/nhocki/contestify/issues) for that. We would like to expand this script and be able to use any other problem (not just the ones from COCI).

This script was started by [Andrés Mejía](https://github.com/andmej). I added the config file option and gemified it.