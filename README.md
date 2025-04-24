
## Documentation


I have completed the technical task as requested. It is a small application for displaying a list of books, including their features, such as the book title, the book's location, the book cover, and the book summary.


# Features



#### Splash Screen
#### Books Screen share with Search Screen

## Tech Stack

**Client:** Flutter

**Server:** https://gutendex.com/


## API Reference

#### Get all items

```http
  GET /books/?page=1
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Not Required**. Your API key |

#### Get item

```http
  GET /books?search=${input}&page=2
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `input`      | `string` | **Required**. input of item to fetch |



## Screenshots

![](../Screenshot_20250425_000638.png)
![](../Screenshot_20250425_000700.png)
![](../Screenshot_20250425_000719.png)
## Related

##### Clean Code Architecture as Design Principle
##### Clean Code and Refactor Code 


