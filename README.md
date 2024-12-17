Here’s a clean and professional **README** for your **GoBikes** project, emphasizing the learning focus while detailing the key aspects of the app:

---

# 🚲 GoBikes - Rent Bike Backend API

GoBikes is a simple backend service designed for a bike rental application. The primary motivation behind this project is to explore **backend engineering**, understand its complexities, and apply key concepts like **database management**, **API development**, and **performance optimization**.

⚠️ **Disclaimer**: This project is created purely for **learning purposes** and is not intended for production use.

---

## 🛠️ **Tech Stack**

- **Programming Language**: Go (Golang)
- **Web Framework**: [Gin](https://github.com/gin-gonic/gin) - Fast HTTP framework for Go
- **Database**: MySQL
- **ORM**: GORM
- **API Testing**: Postman / Curl
- **Tools**: Docker (optional), Git

---

## 📚 **Features**

1. **Vehicle Listing**:  
   - Exposes an API to list all vehicles filtered by location.  
   - Sorts vehicles based on their base cost.  

2. **Cost Calculation**:  
   - API to calculate the final cost based on selected start and end time.  
   - Applies rules like base pricing, hourly charges, and kilometer limits.

3. **Booking Management**:  
   - Place an order to rent a bike for a certain duration.  
   - Generates a unique **order ID** upon successful booking.

4. **Data Relationships**:  
   - Handles relationships between **vehicles**, **locations**, and **costs** using foreign keys.
  
5. **JWT based authentication**
   

---

## 🚀 **API Endpoints [WIP] ⏳ ** 

| **Method** | **Endpoint**                                      | **Description**                                 |
|------------|--------------------------------------------------|-----------------------------------------------|
| `GET`      | `/vehicle/{location_name}`                       | List all vehicles in the specified location.  |
| `GET`      | `/vehicle/{location_name}/{vehicle_id}/{start_time}/{end_time}` | Retrieve the final rental cost.               |
| `POST`     | `/order/vehicle`                                 | Place an order for renting a vehicle.         |

### Example Request: Place an Order
**Endpoint**: `/order/vehicle`  
**Method**: `POST`  
**Request Body**:
```json
{
    "vehicle_id": "1234",
    "start_time": "1734420600",
    "end_time": "1734442200"
}
```

**Response**:
```json
{
    "order_id": "ORD123456",
    "message": "Booking successful"
}
```

---

## ⚙️ **Database Design**

### 1. Vehicles Table
| Column            | Type           | Description                     |
|-------------------|----------------|---------------------------------|
| id                | BIGINT         | Primary Key                     |
| model             | TEXT           | Vehicle model name              |
| year              | BIGINT         | Manufacture year                |
| type_id           | BIGINT         | Foreign key to `vehicle_types`  |
| available         | BOOLEAN        | Availability status             |
| booked_till_date  | TEXT           | Date until the vehicle is booked|
| price_per_hour    | FLOAT          | Hourly rental price             |
| image             | TEXT           | Vehicle image URL               |

### 2. Vehicle Costs Table
| Column          | Type         | Description                       |
|-----------------|--------------|-----------------------------------|
| id              | BIGINT       | Primary Key                       |
| vehicle_id      | BIGINT       | Foreign Key to `vehicles.id`      |
| base_cost       | FLOAT        | Base cost for initial duration    |
| hourly_cost     | FLOAT        | Cost per additional hour          |
| km_limit        | INT          | Kilometers allowed for the period |

### 3. Locations Table
| Column         | Type          | Description                     |
|----------------|---------------|---------------------------------|
| location_id    | BIGINT        | Primary Key                     |
| name           | TEXT          | Location name                   |

---

## 📖 **Learning Outcomes**

This project has been a hands-on experience to understand:
1. Structuring backend services in **Go**.
2. Managing data relationships and performing **JOIN queries** with GORM.
3. Building **RESTful APIs** using the **Gin framework**.
4. Calculating dynamic costs with time-based pricing and constraints.
5. Query optimization and API performance tuning.

---

## 🛠️ **How to Run the Project**

### Prerequisites:
- Install Go (1.19 or higher).
- MySQL Database.
- Git.

### Steps:
1. Clone the repository:
   ```bash
   git clone https://github.com/hardikm9850/Go-Bikes.git
   cd gobikes
   ```

2. Set up MySQL Database:
   - Import the provided `gobikesdb.sql` file.

3. Update `config.json` (or `.env`) with database credentials:
   ```json
   {
       "DB_USER": "root",
       "DB_PASS": "password",
       "DB_NAME": "gobikes",
       "DB_HOST": "localhost",
       "DB_PORT": "3306"
   }
   ```

4. Run the server:
   ```bash
   go run main.go
   ```

5. Test APIs using Postman or Curl.

---

## 🤝 **Contributing**

As this project is for learning purposes, contributions are welcome! Feel free to:
- Report issues.
- Suggest improvements.
- Share ideas for new features.

---

## 📝 **Acknowledgments**

- [Gin Web Framework](https://github.com/gin-gonic/gin) for making API development smooth.
- [GORM](https://gorm.io/) for simplifying database operations.

---

## 📜 **License**

This project is licensed under the MIT License.  
You’re free to use, modify, and distribute the code for learning purposes.

---

## 🎯 **Future Enhancements**

- Implement a **payment gateway** for order payments.
- Enhance cost calculation to include **dynamic discounts** and penalties.
- Containerize the app using **Docker** for easy deployment.
- Write unit tests to improve code quality.
