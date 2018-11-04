/**
 * HTTP Response Handler
 *
 * HTTP client stores the session metadata, which can be modified inside
 * the script. The client's state is preserved until you close IntelliJ IDEA.
 * Every variable saved in `client.global` as `variable_name` is accessible
 * to subsequent HTTP requests as {{variable_name}}.
 *
 * response holds information about the received response: its content type,
 * status, response body, and so on.
 */

// success
client.test("Status code is 200", function() {
    client.assert(response.status === 200, "Response status is not 200");
});
