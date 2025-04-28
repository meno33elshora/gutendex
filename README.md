## Documentation


I have completed the technical task as requested. It is a small application for displaying a list of books, including their features, such as the book title, the book's location, the book cover, and the book summary.
It also contains the most important feature, which is that in the event of an Internet outage, it contains the latest available data.


# Features



#### Splash Screen
#### Books Screen share with Search Screen

## Tech Stack

**Client:** Flutter

**Server:** https://gutendex.com/

**Package:** 
  - Flutter Bloc (Cubit)
  -  Internet Checker
  -  Shared Preferences
  -  Dartz
  -  Get It
  -  dio
  -  Equatable
  -  Readmore


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


<div>  
<img src="https://github.com/user-attachments/assets/b4f6d0cf-a883-4cb1-ba81-9794b5ff6bfd" width = 200 , hight = 200> 
<img src="https://github.com/user-attachments/assets/eb2f6f86-5191-4c34-a267-e19edf66fd9e" width = 200 , hight = 200> 
<img src="https://github.com/user-attachments/assets/0b506325-3af9-46e3-92fb-8a7f60b69f92" width = 200 , hight = 200>   
</div>


## Structural Design

<div> 
<img src="https://github.com/user-attachments/assets/1860f532-2910-404f-88bc-dfe35c4f5cf0" width = 200 , hight = 200> 
</div>


## Related

##### Clean Code Architecture as Design Principle
##### Clean Code and Refactor Code 


