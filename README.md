# README

This is a Ruby on Rails API to read the input xml file and create a `PlacementSeq` protobuf message.

* Ruby version is 3.2.2

## Usage

```plaintext
POST /api/v1/ad_parameters
```

Parameters:

| Attribute   | Type    | Required |  Description                   |
| :-----------|:--------|:---------|:-----------------|
| `file_path` | string  | yes      | Path to xml file |

```shell
curl --request POST \
  --url "https://example.com/api/v1/ad_parameters" \
  --data '{
    "file_path": "path/to/xml/file"
}'
```

Returns the following status codes:

- `200 OK`: successful response.
- `422 Unprocessable Entity`: the expected parameter is missing.
