## How to run:

1. Run `ruby application.rb` inside the `tribe` directory.
2. Input order in the example format:
  - Example 1: 10 IMG 15 FLAC 13 VID
  - Example 2: 15 FLAC
  - Example 3: 10 IMG 15 FLAC
  - Example 4: 12 IMG 15 FLAC 13 VID
  - Example 5: 22 FLAC
3. Press enter - the output will be printed below.

## Conditions and Limitations

1. When you input quantity which is above the bundle it will get the bundle closest to your input.
  - Example:
    ```
      BUNDLE for IMG is [5, 10]
      Then your input is: 8 IMG
      The result is 10 IMG with message offered bundle.
      Example Result for input: 8 IMG
      Order count: 8. Offered bundle 10
      10 IMG $800
            1 x 10 $800
    ```
2. Input has a limit. When loop meet the range and it does not get the result,
  it will return error message with specific input order bundle.
  Example:
  Enter your order below:
  ```
    50 IMG 23 FLAC 100 VID

    Order out of range. Order for VID should not greater than 54.

    Order count: 23. Offered bundle 24.
    24 FLAC $3105.0
                2 x 9 $2295.0
                1 x 6 $810

    Order out of range. Order for IMG should not greater than 40.
```
## Rspec Coverage:

1. Test (computation.rb) computation per [order_count, format_code]. It also covers input that is not divisible from bundles.
2. Test (order.rb) which is the main class. It covers all kinds of inputs. Example:
  - All input: 10 IMG 15 FLAC 13 VID
  - Two input: 10 IMG 15 FLAC
  - Single input: 10 IMG
3. Test (validator.rb), which covers the validation formats.
