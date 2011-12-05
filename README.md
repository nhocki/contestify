Contestify
====

This is a simple ruby gem to automate the process of setting up a programming contest from a COCI problem set using DOMJudge.

Usage
---

```
  contestify coci_problems_url judge_upload_url judge_password
```

This will get the .zip file from the `coci_problems_url` and add the problems to the DOM Judge on the server. This **will not** create a new contest. Just add problems to the current one.

It is assumed that the admin username is `admin`.