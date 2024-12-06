// Create collections
db.createCollection("users");
db.createCollection("categories");
db.createCollection("products");
db.createCollection("orders");
db.createCollection("product_order");
db.createCollection("address");
db.createCollection("admin");

// Insert records into collections

// Users
db.users.insertMany([
    {
        _id: 1,
        firstname: "Akande",
        lastname: "Lateef",
        username: "curious",
        email: "akandelateef0@gmail.com",
        phone_number: "1234567890",
        gender: "male",
        password: "password123",
        created_at: new Date(),
        updated_at: new Date()
    },
    {
        _id: 2,
        firstname: "Omotayo",
        lastname: "Fatima",
        username: "chinaza",
        email: "omofachi@example.com",
        phone_number: "0987654321",
        gender: "female",
        password: "password456",
        created_at: new Date(),
        updated_at: new Date()
    }
]);

// Categories
db.categories.insertMany([
    { _id: 1, name: "Electronics", slug: "electronics", parent_id: null, created_at: new Date(), updated_at: new Date() },
    { _id: 2, name: "Phones", slug: "phones", parent_id: 1, created_at: new Date(), updated_at: new Date() },
    { _id: 3, name: "Laptops", slug: "laptops", parent_id: 1, created_at: new Date(), updated_at: new Date() }
]);

// Products
db.products.insertMany([
    {
        _id: 1,
        name: "Samsung Galaxy S21",
        slug: "samsung-galaxy-s21",
        size: "M",
        category_id: 2,
        price: 200000.0,
        weight: 0.5,
        is_wholesale: false,
        amount_in_stock: 100,
        created_at: new Date(),
        updated_at: new Date()
    },
    {
        _id: 2,
        name: "HP Pavilion 15",
        slug: "hp-pavilion-15",
        size: "L",
        category_id: 3,
        price: 300000.0,
        weight: 1.5,
        is_wholesale: true,
        amount_in_stock: 50,
        created_at: new Date(),
        updated_at: new Date()
    }
]);

// Address
db.address.insertMany([
    {
        _id: 1,
        address1: "No 1, Lagos Road",
        address2: "Opposite Shoprite",
        landmark: "Ojodu",
        city: "Lagos",
        lga: "Ikeja",
        state: "Lagos",
        country: "Nigeria",
        user_id: 1,
        created_at: new Date(),
        updated_at: new Date(),
        type: "shipping"
    },
    {
        _id: 2,
        address1: "No 2, Lagos Road",
        address2: "Opposite Shoprite",
        landmark: "Ojodu",
        city: "Lagos",
        lga: "Ikeja",
        state: "Lagos",
        country: "Nigeria",
        user_id: 1,
        created_at: new Date(),
        updated_at: new Date(),
        type: "billing"
    }
]);

// Orders
db.orders.insertOne({
    _id: 1,
    order_no: "ORD-123456",
    status: "processing",
    billing_address_id: 2,
    shipping_address_id: 1,
    created_at: new Date(),
    updated_at: new Date()
});

// Product Order
db.product_order.insertMany([
    { _id: 1, order_id: 1, product_id: 1 },
    { _id: 2, order_id: 1, product_id: 2 }
]);

// Admin
db.admin.insertOne({
    _id: 1,
    roles: "admin",
    user_id: 1,
    created_at: new Date(),
    updated_at: new Date()
});

// Querying records

// Getting user with id 1
db.users.find({ _id: 1 });

// Getting all products
db.products.find();

// Getting orders that belong to user with id 1 (billing address as filter)
db.orders.find({ billing_address_id: 2 });

// Updating records
db.users.updateOne({ _id: 1 }, { $set: { firstname: "Olayinka" } });
db.products.updateOne({ _id: 1 }, { $set: { price: 250000.0 } });
db.orders.updateOne({ _id: 1 }, { $set: { status: "shipped" } });

// Deleting records
db.users.deleteOne({ _id: 2 });
db.products.deleteOne({ _id: 2 });
db.orders.deleteOne({ _id: 1 });

// Querying records from two or more collections (using manual join logic)
db.products.aggregate([
    {
        $lookup: {
            from: "categories",
            localField: "category_id",
            foreignField: "_id",
            as: "category_details"
        }
    }
]);
