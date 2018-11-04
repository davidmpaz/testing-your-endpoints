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
client.test("Status code is 201", function() {
    client.assert(response.status === 201, "Response status is not 200");
});

client.global.set('todo', response.body);
client.global.set('todoId', response.body.id);

client.test("Creation request send TODO back", function() {
    client.assert(
        response.body.title === "Do your presentation",
        "TODO was not created"
    );
});