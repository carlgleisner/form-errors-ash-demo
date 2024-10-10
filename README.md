# Form Errors in AshPhoenix Demo

This is a simple demonstration of a potential issue regarding the handling of form errors in [AshPhoenix](https://hexdocs.pm/ash_phoenix/readme.html) with [Phoenix LiveView 1.0.0-rc6](https://hexdocs.pm/phoenix_live_view/1.0.0-rc.6/).

The `used_input?/1` function in the upcoming LiveView 1.0 replaces the previous `phx-feedback-for` annotation for hiding not yet relevant errors as per the [Phoenix LiveView changelog](https://hexdocs.pm/phoenix_live_view/1.0.0-rc.6/changelog.html#backwards-incompatible-changes-for-1-0).

The generated core components filter now hides errors by checking `field.errors` and assigning any errors to `@errors` if any, otherwise setting `@errors` to `nil`.

This application has a small demonstration form at `/` together with `dbg` calls for debugging.

```bash
mix setup
mix phx.server
```

Then go to `http://localhost:4000/` and order something edible 🌮
