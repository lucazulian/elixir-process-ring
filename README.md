# elixir-process-ring
Process ring exercise in Elixir

``` elixir
  Create a ring of `n` processes where the parent process knows the child process so that it
  can send messages to it.
  Every process should wait for a message and then forward it to its child process.
  The message should keep a counter that will incremented every time the message is sent so
  that we can check if the whole ring is completed.
  We should be able to make `m` rounds of messages in the ring and benchmark how much time
  does it take.
  
  Ideas:
  - Create a message to shutdown the ring
  - Create a ring where the root of the ring is not the current process
  - Shutdown the ring by killing the root of the ring
  - Implement the ring with OTP `GenServer`s and benchmark the difference
  - Implement the Ring behaviour by refactoring the `GenServer` implementation
```
