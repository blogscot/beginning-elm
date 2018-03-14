# Allowing Cross-Origin Resource Sharing

How do we fix this cross-origin issue? A solution is lurking in the error message. If you look closely, the browser is telling us what it expects: No 'Access-Control-Allow-Origin' header is present on the requested resource.

Access-Control-Allow-Origin is one of the headers included in a response sent by the server. It indicates which domains are allowed to use the response. For example, if the server returns Access-Control-Allow-Origin: _, the response can be used by any domain. But if the server wants only certain domains to have access then it’ll return a domain name(s) instead of _. Here’s an example: Access-Control-Allow-Origin: `http://localhost:8000`.

If you check out the documentation for the http-server package we used earlier to create a local server, you’ll notice that there is an option called --cors that enables Cross-Origin Resource Sharing (CORS) via the Access-Control-Allow-Origin header. Let’s stop our local server by pressing Ctrl + c and then restart it using the --cors option.

## Lessons Learned

1.  `http-server` supports CORS out of the box
1.  `Firefox` browser does not support this, however, `Firefox Developer Edition` does!
1.  `elm-live` can be used to handle Navigation - `elm-reactor` does not support this!
1.  The `source-directories` defined in `elm-package.json` does not need to contain all the the project's subdirectories - it just needs to include the directory where 'Main.elm' is located.
