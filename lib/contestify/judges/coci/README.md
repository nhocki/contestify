Contestify::Coci
===

This strategy will upload the problems from a given URL to the server. Usage:

    contestify coci problem_url judge_upload_url judge_admin_password

Note that the Judge URL is the actual **upload** URL, which is normally `http://you-dom-judge.com/jury/problem.php`.

Here's an example of usage with _real_ data:

    contestify http://hsin.hr/coci/contest1_testdata.zip http://domjudge.factorcomun.org/jury/problem.php p4ssw0rd
