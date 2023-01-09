DROP DATABASE IF EXISTS smartPhoneShop;
CREATE DATABASE smartPhoneShop;
USE smartPhoneShop;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
	id 						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	username				VARCHAR(255) NOT NULL UNIQUE KEY,
	email 					VARCHAR(255) NOT NULL UNIQUE KEY,
	fullname				VARCHAR(255) NOT NULL,
	`password`				VARCHAR(255) NOT NULL,
    phone					VARCHAR(15) NOT NULL UNIQUE KEY,
	address					VARCHAR(500) NOT NULL,
	`role` 					ENUM('CLIENT','ADMIN') DEFAULT 'CLIENT',
	`status`				TINYINT,  -- 0 : not active / 1 : actived
    avatar					VARCHAR(500) NOT NULL
);


DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
	id						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`name` 					VARCHAR(255) NOT NULL,
	`status`				TINYINT DEFAULT 1
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id 						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`title` 				varchar(255) NOT NULL UNIQUE,
	`descriptions` 			VARCHAR(1000) NOT NULL,
	originalPrice 			INT UNSIGNED NOT NULL,
	promotionPrice  		INT UNSIGNED,
	`created_Date` 			DATETIME DEFAULT now(),
	categoryId 					TINYINT UNSIGNED NOT NULL,
	amount					SMALLINT NOT NULL,
	`status` 				TINYINT DEFAULT 1,
    FOREIGN KEY(categoryId) REFERENCES categories(id)
);

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
	id 								TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	user_Id							TINYINT UNSIGNED UNIQUE KEY NOT NULL,
    amount							TINYINT UNSIGNED DEFAULT 0,
	FOREIGN KEY(user_Id) REFERENCES `users`(id) ON DELETE CASCADE
);



DROP TABLE IF EXISTS `cartItems`;
CREATE TABLE `cartItems` (
	id						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	cart_Id 							TINYINT UNSIGNED,
	product_Id						TINYINT UNSIGNED,
 	amount 							TINYINT UNSIGNED  NOT NULL,
	FOREIGN KEY(product_Id) REFERENCES products(id),
	FOREIGN KEY(cart_Id) REFERENCES cart(id)
);	

DROP TABLE IF EXISTS `PRODUCT_RATES`;
CREATE TABLE `PRODUCT_RATES`(
	id 								TINYINT unsigned PRIMARY KEY AUTO_INCREMENT,
    user_Id 							TINYINT unsigned not null,
    product_Id 						TINYINT unsigned not null,
    `value` 						TINYINT unsigned not null,
    `comment` 						VARCHAR(1000) NOT NULL,
    created_At 						DATETIME DEFAULT NOW(),
    update_At 						DATETIME,
    FOREIGN KEY(user_Id) REFERENCES users(id),
    FOREIGN KEY(product_Id) REFERENCES products(id)
);

DROP TABLE IF EXISTS ProductImages;
CREATE TABLE ProductImages(
	id 								TINYINT unsigned PRIMARY KEY AUTO_INCREMENT,
    image_Url 						VARCHAR(500) NOT NULL,
    created_At 						DATETIME DEFAULT NOW(),
    imagePublicId					VARCHAR(500),
    updated_At						DATETIME,
    product_Id 						TINYINT UNSIGNED,
    FOREIGN KEY(product_Id) REFERENCES Products(id)
);
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
	id 									TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	user_Id 							TINYINT UNSIGNED NOT NULL,
    amount							TINYINT UNSIGNED DEFAULT 0,
	FOREIGN KEY(user_Id) REFERENCES `users`(id)
);

DROP TABLE IF EXISTS `orderItems`;
CREATE TABLE `orderItems` (
	id								TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	order_Id 						TINYINT UNSIGNED NOT NULL,
	product_Id						TINYINT UNSIGNED NOT NULL,
	created_Date 					DATETIME DEFAULT NOW(),
	received_Date 					DATE ,
    amount							INT UNSIGNED NOT NULL,
	`status` 						ENUM('Processing','Processed' ,'Delivering' , 'Complete')  DEFAULT 'Processing',
	FOREIGN KEY(product_Id) REFERENCES products(id),
	FOREIGN KEY(order_Id) REFERENCES orders(id)
);

DROP TABLE IF EXISTS RegistrationUserToken;
CREATE TABLE RegistrationUserToken(
	id 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    token	VARCHAR(500) UNIQUE KEY,
    userId  TINYINT UNSIGNED UNIQUE KEY,
    FOREIGN KEY(userId) REFERENCES users(id)
);

DROP TABLE IF EXISTS ResetPasswordUserToken;
CREATE TABLE ResetPasswordUserToken(
	id 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    token	VARCHAR(500) UNIQUE KEY,
    userId  TINYINT UNSIGNED UNIQUE KEY,
    FOREIGN KEY(userId) REFERENCES users(id)
);

	
-- ====================================  INSERT DATA ============================================
-- password : 123456
INSERT INTO `users` (`username` , `email`, `fullname`, `password`,`phone`, `role`, `address`, `status` , avatar) VALUES
('adminShop' , 'admin@gmail.com', 'Lê Chí Tài', '$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi','0123456788', 'Admin', 'Ha Noi', 1 ,'123'),
('lct1404' ,'lechitai@gmail.com', 'Lê Chí Tài', '$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi','0123456789','Client', 'HaTinh', 1 , '123');

insert into Cart (user_Id) values (2);
insert into Orders (user_Id) values (2);

INSERT INTO categories (`name`) VALUES
('OPPO'),
('IPHONE'),
('XIAOMI'),
('SAMSUNG'),	
('REALME');

INSERT INTO `products` (`title`, `originalPrice`, `promotionPrice`,  `categoryId`, `amount`, `descriptions`, `status`) VALUES
('Iphone 11', '14990000', '12990000', 2, 96, 'Tinh xảo và tỉ mỉ từng chi tiết, khung nhôm bền bỉ, mặt kính cường lực chắc chắn. Camera góc rộng 12MP, cảm biến mới với Focus Pixel 100% lấy nét tự động nhanh hơn gấp 3 lần trong điều kiện thiếu sáng, góc siêu rộng 12MP, chụp cảnh rộng hơn gấp 4 lần, phù hợp đi du lịch, chụp nội thất...Tăng dung lượng pin và thời gian trải nghiệm so với Ipone 10 với khả năng sạc nhanh, sạc đầy pin tiết kiệm thời gian hơn.', 1),
('Iphone 13 pro', '31290000', '31190000', 2, 9, 'Iphone 13 pro là một sản phẩm có màn hình siêu đẹp, tần số quét được nâng cấp lên 120 Hz mượt mà, cảm biến camera có kích thước lớn hơn, cùng hiệu năng mạnh mẽ với sức mạnh đến từ Apple A15 Bionic, sẵn sàng cùng bạn chinh phục mọi thử thách.', 1),
('Oppo A95', '6990000', '6240000',  1, 19, 'Bên cạnh phiên bản 5G, OPPO còn bổ sung phiên bản OPPO A95 4G với giá thành phải chăng tập trung vào thiết kế năng động, sạc nhanh và hiệu năng đa nhiệm ấn tượng sẽ giúp cho cuộc sống của bạn thêm phần hấp dẫn, ngập tràn niềm vui.', 1),
('OPPO Reno6 Z 5G', '9490000', '8990000',  1, 8, 'Reno6 Z 5G đến từ nhà OPPO với hàng loạt sự nâng cấp và cải tiến không chỉ ngoại hình bên ngoài mà còn sức mạnh bên trong. Đặc biệt, chiếc điện thoại được hãng đánh giá “chuyên gia chân dung bắt trọn mọi cảm xúc chân thật nhất”, đây chắc chắn sẽ là một “siêu phẩm" mà bạn không thể bỏ qua.', 1),
('OPPO Reno7 Z 5G', '10490000', '10490000',  1, 7, 'OPPO đã trình làng mẫu Reno7 Z 5G với thiết kế OPPO Glow độc quyền, camera mang hiệu ứng như máy DSLR chuyên nghiệp cùng viền sáng kép, máy có một cấu hình mạnh mẽ và đạt chứng nhận xếp hạng A về độ mượt.', 1),
('Realme C25Y 64GB', '4690000', '4190000',  5, 8, 'Realme C25Y 64GB - là chiếc smartphone được Realme cho ra mắt với một mức giá khá tốt, sở hữu thiết kế hiện đại với 3 camera AI lên đến 50 MP, hiệu suất ổn định cùng thời gian sử dụng lâu dài nhờ viên pin khủng 5000 mAh, được xem là một trong những sản phẩm lý tưởng mà bạn nên sở hữu.', 1),
('Realme C35 64GB', '3990000', '3990000',  5, 7, 'Realme C35 thuộc phân khúc giá rẻ được nhà Realme cho ra mắt với thiết kế trẻ trung, dung lượng pin lớn cùng camera hỗ trợ nhiều tính năng. Đây sẽ là thiết bị liên lạc, giải trí và làm việc ổn định,… cho các nhu cầu sử dụng của bạn.', 1),
('Samsung Galaxy A53 5G 128GB', '9990000', '9090000',  4, 6, 'Samsung Galaxy A53 5G 128GB trình làng với một thiết kế hiện đại, hiệu năng ổn định cùng một màn hình hiển thị sắc nét, hỗ trợ tần số quét cao giúp bạn có được những phút giây giải trí cực kỳ đã mắt, hay thỏa mãn đam mê nhiếp ảnh trong bạn nhờ trang bị camera có độ phân giải cao.', 1),
('Samsung Galaxy S21 Ultra 5G 128GB', '30990000', '22990000', 4, 10, 'Sự đẳng cấp được Samsung gửi gắm thông qua chiếc smartphone Galaxy S21 Ultra 5G với hàng loạt sự nâng cấp và cải tiến không chỉ ngoại hình bên ngoài mà còn sức mạnh bên trong, hứa hẹn đáp ứng trọn vẹn nhu cầu ngày càng cao của người dùng.', 1),
('Samsung Galaxy S22 Ultra 5G 128GB', '30990000', '30990000', 4, 10, 'Galaxy S22 Ultra 5G chiếc smartphone cao cấp nhất trong bộ 3 Galaxy S22 series mà Samsung đã cho ra mắt. Tích hợp bút S Pen hoàn hảo trong thân máy, trang bị vi xử lý mạnh mẽ cho các tác vụ sử dụng vô cùng mượt mà và nổi bật hơn với cụm camera không viền độc đáo mang đậm dấu ấn riêng.', 1),
('Samsung Galaxy Z Fold3 5G 256GB', '41990000', '33990000',  4, 10, 'Galaxy Z Fold3 5G, chiếc điện thoại được nâng cấp toàn diện về nhiều mặt, đặc biệt đây là điện thoại màn hình gập đầu tiên trên thế giới có camera ẩn (08/2021). Sản phẩm sẽ là một “cú hit” của Samsung góp phần mang đến những trải nghiệm mới cho người dùng.', 1),
('Xiaomi 11T 5G 256GB', '11990000', '11990000',  3, 20, 'Xiaomi 11T 5G sở hữu màn hình AMOLED, viên pin siêu khủng cùng camera độ phân giải 108 MP, chiếc smartphone này của Xiaomi sẽ đáp ứng mọi nhu cầu sử dụng của bạn, từ giải trí đến làm việc đều vô cùng mượt mà. ', 1),
('Xiaomi Redmi 10C 64GB', '3490000', '3490000',  3, 15, 'Xiaomi Redmi 10C ra mắt với một cấu hình mạnh mẽ nhờ trang bị con chip 6 nm đến từ Qualcomm, màn hình hiển thị đẹp mắt, pin đáp ứng nhu cầu sử dụng cả ngày, hứa hẹn mang đến trải nghiệm tuyệt vời so với mức giá mà nó trang bị.', 1),
('iPhone 12 Pro Max 512GB', '30990000', '30990000',  2, 15, 'Điện thoại iPhone 12 Pro Max 512GB - đẳng cấp từ tên gọi đến từng chi tiết. Ngay từ khi chỉ là tin đồn thì chiếc smartphone này đã làm đứng ngồi không yên bao “fan cứng” nhà Apple, với những nâng cấp vô cùng nổi bật hứa hẹn sẽ mang đến những trải nghiệm tốt nhất về mọi mặt mà chưa một chiếc iPhone tiền nhiệm nào có được', 1),
('iPhone XR 128GB', '13990000', '13490000', 2, 15, 'Được xem là phiên bản iPhone giá rẻ đầy hoàn hảo, iPhone Xr 128GB khiến người dùng có nhiều sự lựa chọn hơn về màu sắc đa dạng nhưng vẫn sở hữu cấu hình mạnh mẽ và thiết kế sang trọng', 1),
('iPhone SE 64GB (2020)', '9490000', '9490000',  2, 15, ' Điện thoại iPhone SE 2020 đã bất ngờ ra mắt với thiết kế 4.7 inch nhỏ gọn, chip A13 Bionic mạnh mẽ như trên iPhone 11 và đặc biệt sở hữu mức giá tốt chưa từng có	', 1),
('Samsung Z Flig3 5G 128GB', '24990000', '24990000',  4, 15, 'Samsung Galaxy Z Flip3 5G được trình làng với các màu sắc thời thượng bao gồm: Đen, Tím, Kem, Xanh lá. Hãng tạo ra rất nhiều lựa chọn cho người dùng phù hợp với cá tính của riêng mình. Điện thoại có kích thước 167.3 x 73.6 x 7.2mm với trọng lượng 183g, sản phẩm được đánh giá là nhỏ gọn đáng kể hơn so với Z Flip 5G. Thế nhưng thiết kế màn hình phụ lại lên tới 1.9 inch, lớn hơn đáng kể.', 1),
('Xiaomi 12', '19990000', '19990000', 3, 15, 'Xiaomi đang dần khẳng định chỗ đứng của mình trong phân khúc điện thoại flagship bằng việc ra mắt Xiaomi 12 với bộ thông số ấn tượng, máy có một thiết kế gọn gàng, hiệu năng mạnh mẽ, màn hình hiển thị chi tiết cùng khả năng chụp ảnh sắc nét nhờ trang bị ống kính đến từ Sony.', 1),
('Xiaomi Redmi Note 10 Pro (8GB/128GB)', '7490000', '7490000',  3, 15, 'Kế thừa và nâng cấp từ thế hệ trước, Xiaomi đã cho ra mắt điện thoại Xiaomi Redmi Note 10 Pro (8GB/128GB) sở hữu một thiết kế cao cấp, sang trọng bên cạnh cấu hình vô cùng mạnh mẽ, hứa hẹn mang đến sự cạnh tranh lớn trong phân khúc smartphone tầm trung', 1),
('Xiaomi Redmi Note 11S 5G', '6490000', '6490000',  3, 15, 'Tại sự kiện ra mắt sản phẩm mới diễn ra hôm 29/3, Xiaomi đã ra mắt Xiaomi Redmi Note 11S 5G toàn cầu. Thiết bị là một bản nâng cấp đáng giá so với Redmi Note 11S 4G, cùng xem máy có gì đặc biệt thôi nào.', 1),
('Realme 9 Pro 5G', '7990000', '7990000',  5, 15, 'Realme 9 Pro - chiếc điện thoại tầm trung được Realme giới thiệu với thiết kế phản quang hoàn toàn mới, máy có một vẻ ngoài năng động, hiệu năng mạnh mẽ, cụm camera AI 64 MP và một tốc độ sạc ổn định', 1),
('Realme 8', '6790000', '6790000', 5, 15, 'Điện thoại Realme 8 được ra mắt nằm trong phân khúc tầm trung, có thiết kế đẹp mắt đặc trưng của Realme, smartphone trang bị hiệu năng bên trong đầy mạnh mẽ và có dung lượng pin tương đối lớn.', 1),
('Realme 9i (4GB/64GB)', '5490000', '5490000', 5, 15, 'Realme đang ngày càng cải thiện hơn rất nhiều ở các sản phẩm của họ và sản phẩm gần đây nhất đó là dòng điện thoại Realme 9i. Chiếc điện thoại này được sở hữu con chip Snapdragon 680 kết hợp cùng với các tiện ích khác, hứa hẹn sẽ mang lại cho bạn sự trải nghiệm hiệu năng ổn định, mượt mà.', 1),
('OPPO Find X5 Pro 5G', '32990000', '30990000',  1, 15, 'Dòng Find X đến từ OPPO luôn mang trên mình những công nghệ hàng đầu trong ngành công nghiệp điện thoại. OPPO Find X5 Pro cũng sở hữu những thông số kỹ thuật chuẩn flagship năm 2022, có thể kể đến như vi xử lý Snapdragon 8 Gen 1, màn hình 2K+ sắc nét, camera Sony và sạc nhanh 80 W.', 1),
('OPPO Reno4 Pro', '10490000', '7990000',  1, 15, 'OPPO chính thức trình làng chiếc smartphone có tên OPPO Reno4 Pro. Máy trang bị cấu hình vô cùng cao cấp với vi xử lý chip Snapdragon 720G, bộ 4 camera đến 48 MP ấn tượng, cùng công nghệ sạc siêu nhanh 65 W nhưng được bán với mức giá vô ưu đãi, dễ tiếp cận', 1);





INSERT INTO `ProductImages` (`image_Url`, `product_Id`) VALUES
('iphone-11-do-1-1-1-org.jpg' , 1),
('iphone-13-pro-xanh-xa-1.jpg' , 2),
('oppo-a95-4g-bac-1-1.jpg' , 3),
('oppo-reno6-z-5g-bac-1-org.jpg' , 4),
('oppo-reno7-z-1-1.jpg' , 5),
('realme-c25y-1-2.jpg' , 6),
('realme-c35-1-2.jpg' , 7),
('samsung-galaxy-a53-1-1.jpg' , 8),
('samsung-galaxy-s21-ultra-bac-1-org.jpg' , 9),
('samsung-galaxy-s22-ultra-1.jpg' , 10),
('samsung-galaxy-z-fold-3-1-3.jpg' , 11),
('xiaomi-11t-1-1.jpg' , 12),
('xiaomi-redmi-10c-1-1.jpg' , 13),
('iphone-12-pro-max-512gb-xam-1-org.jpg' , 14),
('iphone-xr-128gb-trang-1-1-org.jpg' , 15),
('iphone-se-64gb-2020-hop-moi-den-1-1-org.jpg' , 16),
('Samsung0-Galaxy-Z-Fold3-5G-256GB.jpg' , 17),
('xiaomi-12-1.jpg' , 18),
('xiaomi-redmi-note-10-pro-xam-1-org.jpg' , 19),
('xiaomi-redmi-note-11s-5g-lam-hong-1.jpg' , 20),
('realme-9-pro-1-1.jpg' , 21),
('realme-8-bac-1-org.jpg' ,22),
('realme-9i-den-1.jpg' , 23),
('oppo-find-x5-pro-1-2.jpg' , 24),
('oppo-reno4-pro-trang-1-org.jpg' , 25);


insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (1, 1, 6, 4, 'Thrasher, curve-billed');
insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (2, 1, 9, 3, 'Turkey vulture');
insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (3, 1, 8, 4, 'Tiger snake');
insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (4, 2, 8, 5, 'Bushbuck');
insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (5, 1, 5, 5, 'Armadillo, seven-banded');
insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (6, 2, 3, 1, 'Sugar glider');
insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (7, 1, 6, 4, 'Elephant, african');
insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (8, 1, 4, 1, 'Cormorant, javanese');
insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (9, 1, 3, 4, 'Ibis, puna');
insert into PRODUCT_RATES (id, user_Id, product_Id, value, comment) values (10, 1, 9, 5, 'Bee-eater, white-fronted');


-- insert into cartItems (id, cart_Id, product_Id, amount) values (1, 1, 1, 2);
-- insert into cartItems (id, cart_Id, product_Id, amount) values (2, 1, 2, 5);
-- insert into cartItems (id, cart_Id, product_Id, amount) values (3, 1, 3, 3);
-- insert into cartItems (id, cart_Id, product_Id, amount) values (4, 1, 4, 1);
-- insert into cartItems (id, cart_Id, product_Id, amount) values (5, 1, 5, 1);
-- insert into cartItems (id, cart_Id, product_Id, amount) values (6, 1, 6, 5);
-- insert into cartItems (id, cart_Id, product_Id, amount) values (7, 1, 7, 5);
-- insert into cartItems (id, cart_Id, product_Id, amount) values (8, 1,8, 2);
-- insert into cartItems (id, cart_Id, product_Id, amount) values (9, 1, 9, 3);
-- insert into cartItems (id, cart_Id, product_Id, amount) values (10, 1, 10, 1);


-- insert into orderItems (id, order_Id, product_Id,received_Date ,amount) values (1, 1, 1, '2022-07-19' , 1); 
-- insert into orderItems (id, order_Id, product_Id,received_Date,amount) values (2, 1, 1,'2022-07-19',2);
-- insert into orderItems (id, order_Id, product_Id,amount) values (3, 1, 2,3);
-- insert into orderItems (id, order_Id, product_Id,amount) values (4, 1, 1,2);
-- insert into orderItems (id, order_Id, product_Id,amount) values (5, 1, 1,5);
-- insert into orderItems (id, order_Id, product_Id,amount) values (6, 1, 3,2);
-- insert into orderItems (id, order_Id, product_Id,amount) values (7, 1, 3,6);
-- insert into orderItems (id, order_Id, product_Id,amount) values (8, 1, 2,1);
-- insert into orderItems (id, order_Id, product_Id,amount) values (9, 1, 3,3);
-- insert into orderItems (id, order_Id, product_Id,amount) values (10, 1,3,2);


DROP TRIGGER IF EXISTS auto_rendCart_withUSer;
DELIMITER $$
CREATE TRIGGER auto_rendCart_withUSer
AFTER INSERT ON users
FOR EACH ROW
BEGIN 
	DECLARE v_userId tinyint;
    SELECT id INTO v_userId
    FROM users u
    WHERE id = NEW.id;
    
    INSERT INTO Cart (user_Id) values (v_userId);
	INSERT INTO Orders (user_Id) values (v_userId);
END $$
DELIMITER ;