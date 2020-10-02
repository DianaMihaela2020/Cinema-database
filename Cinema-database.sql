-- Cinema database

create database Cinema;
use Cinema;

DROP TABLE IF EXISTS `clients`;

CREATE TABLE `clients` (
  `clientId` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `dateOfBirth` date NOT NULL,
  PRIMARY KEY (`clientId`)
) AUTO_INCREMENT= 4; 


INSERT INTO `clients` VALUES (1,'John','Johnson','john@johnson.com','1980-01-01'),(2,'Jim','Jameson','jim@jameson.com','1990-02-02'),(3,'Sofia','Sophie','sofia@sophie','2000-01-01');

DROP TABLE IF EXISTS `movies`;

CREATE TABLE `movies` (
  `movieId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  `durationInMinutes` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`movieId`)
);


INSERT INTO `movies` VALUES (1,'Men in Black: International','Action',114,'The Men in Black have always protected the Earth from the scum of the universe. In this new adventure, they tackle their biggest threat to date: a mole in the Men in Black organization.'),(2,'Joker','Crime, Drama, Thriller ',122,'In Gotham City, mentally troubled comedian Arthur Fleck is disregarded and mistreated by society. He then embarks on a downward spiral of revolution and bloody crime. This path brings him face-to-face with his alter-ego: the Joker.'),(3,'Frozen II','Animation, Adventure, Comedy ',103,'Anna, Elsa, Kristoff, Olaf and Sven leave Arendelle to travel to an ancient, autumn-bound forest of an enchanted land. They set out to find the origin of Elsa\'s powers in order to save their kingdom.'),(4,'Parasite','Comedy, Crime, Drama',132,'A poor family, the Kims, con their way into becoming the servants of a rich family, the Parks. But their easy life gets complicated when their deception is threatened with exposure.');

DROP TABLE IF EXISTS `reservation_seat`;

CREATE TABLE `reservation_seat` (
  `reservationSeatId` int(11) NOT NULL AUTO_INCREMENT,
  `reservationId` int(11) NOT NULL,
  `seatId` int(11) NOT NULL,
  PRIMARY KEY (`reservationSeatId`),
  KEY `fk_reseseat_reservation_idx` (`reservationId`),
  KEY `fk_reseseat_seat_idx` (`seatId`),
  CONSTRAINT `fk_reseseat_reservation` FOREIGN KEY (`reservationId`) REFERENCES `reservations` (`reservationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_reseseat_seat` FOREIGN KEY (`seatId`) REFERENCES `seats` (`seatId`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO `reservation_seat` VALUES (1,1,1),(2,1,2);

DROP TABLE IF EXISTS `reservations`;


CREATE TABLE `reservations` (
  `reservationId` int(11) NOT NULL AUTO_INCREMENT,
  `isPaid` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `scheduleId` int(11) NOT NULL,
  PRIMARY KEY (`reservationId`),
  KEY `fk_reservation_client_idx` (`clientId`),
  KEY `fk_reservation_schedule_idx` (`scheduleId`),
  CONSTRAINT `fk_reservation_client` FOREIGN KEY (`clientId`) REFERENCES `clients` (`clientId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_schedule` FOREIGN KEY (`scheduleId`) REFERENCES `schedules` (`scheduleId`) ON DELETE NO ACTION ON UPDATE NO ACTION
);



INSERT INTO `reservations` VALUES (1,0,1,1);
DROP TABLE IF EXISTS `rooms`;

CREATE TABLE `rooms` (
  `roomId` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `maxSeats` int(11) NOT NULL,
  `location` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`roomId`)
);


INSERT INTO `rooms` VALUES (1,1,180,'Ground Floor'),(2,2,120,'Ground Floor'),(3,3,180,'Ground Floor'),(4,4,220,'First Floor'),(5,5,230,'First Floor');

DROP TABLE IF EXISTS `schedules`;

CREATE TABLE `schedules` (
  `scheduleId` int(11) NOT NULL AUTO_INCREMENT,
  `startTime` datetime NOT NULL,
  `movieId` int(11) NOT NULL,
  `roomId` int(11) NOT NULL,
  PRIMARY KEY (`scheduleId`),
  KEY `fk_schedule_movie_idx` (`movieId`),
  KEY `fk_schdule_room_idx` (`roomId`),
  CONSTRAINT `fk_schdule_room` FOREIGN KEY (`roomId`) REFERENCES `rooms` (`roomId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_movie` FOREIGN KEY (`movieId`) REFERENCES `movies` (`movieId`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO `schedules` VALUES (1,'2020-01-01 20:00:00',1,1),(2,'2020-01-01 20:00:00',2,2),(3,'2020-01-01 23:00:00',3,1),(4,'2020-01-02 18:00:00',1,1);

DROP TABLE IF EXISTS `seats`;


CREATE TABLE `seats` (
  `seatId` int(11) NOT NULL AUTO_INCREMENT,
  `row` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `roomId` int(11) NOT NULL,
  PRIMARY KEY (`seatId`),
  KEY `fk_seat_room_idx` (`roomId`),
  CONSTRAINT `fk_seat_room` FOREIGN KEY (`roomId`) REFERENCES `rooms` (`roomId`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


INSERT INTO `seats` VALUES (1,1,1,1),(2,1,2,1),(3,1,3,1),(4,2,1,1),(5,2,2,1),(6,2,3,1),(12,1,1,2),(13,1,2,2),(14,1,3,2),(15,2,1,2),(16,2,2,2),(17,2,3,2);

DROP TABLE IF EXISTS `ticketCategories`;

CREATE TABLE `ticketCategories` (
  `ticketCategoryId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`ticketCategoryId`)
);


INSERT INTO `ticketCategories` VALUES (1,'ADULT',100),(2,'CHILDREN',80),(3,'ELDERLY',50);
DROP TABLE IF EXISTS `tickets`;


CREATE TABLE `tickets` (
  `ticketId` int(11) NOT NULL AUTO_INCREMENT,
  `scheduleId` int(11) NOT NULL,
  `seatId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  PRIMARY KEY (`ticketId`),
  KEY `fk_ticket_schedule_idx` (`scheduleId`),
  KEY `fk_ticket_seat_idx` (`seatId`),
  KEY `fk_ticket_category_idx` (`categoryId`),
  CONSTRAINT `fk_ticket_category` FOREIGN KEY (`categoryId`) REFERENCES `ticketCategories` (`ticketCategoryId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_schedule` FOREIGN KEY (`scheduleId`) REFERENCES `schedules` (`scheduleId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_seat` FOREIGN KEY (`seatId`) REFERENCES `seats` (`seatId`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO `tickets` VALUES (1,2,1,1),(2,2,1,2);

-- pag 60  ex: 1
-- 1.List all movies.

select * from movies;

-- 2. List all movies running on 2020-01-01. (movies name and start time)

select movies.name, schedules.startTime
from movies
inner join schedules on movies.movieId = schedules.movieId
where schedules.startTime < "2020-01-02";


-- 3.List all movies that are not yet scheduled to run in the cinema.

select movies.name
from movies
inner join schedules on movies.movieId = schedules.movieId
where schedules.startTime is null;

-- 4.List all movies reserved by John Johnson.
select name from movies where movieId = (
	select schedules.movieId
	from reservations
	inner join clients on clients.clientId = reservations.clientId
	inner join schedules on reservations.scheduleId = schedules.scheduleId
	where reservations.clientId =
		(select clientId from clients  where firstName = "John" and lastName = "Johnson")
);

-- 5.List all the seat rows and numbers reserved by John Johnson.
select Seats.row, number from Seats where seatId in (
	select reservation_seat.seatId
	from reservations
	inner join reservation_seat on reservations.reservationId = reservation_Seat.reservationId
	inner join clients on reservations.clientId = clients.clientId
	where reservations.clientId =
		(select clientId from clients  where firstName = "John" and lastName = "Johnson")
		
);

-- 6. List all tickets sold for Joker.

select tickets.ticketId 
from schedules
inner join tickets on  schedules.scheduleId = tickets.scheduleId
inner join movies on schedules.movieId = movies.movieId
where movies.name = "Joker";


-- 7. List the number of adult and children tickets sold for Joker.

select COUNT(tickets.ticketId) AS "the number of adult and children tickets sold for Joker"
from schedules
inner join tickets on  schedules.scheduleId = tickets.scheduleId
inner join movies on schedules.movieId = movies.movieId
where movies.name = "Joker" AND tickets.categoryId in (
	select ticketCategoryId from ticketCategories  where type = "ADULT" or type = "CHILDREN"
);

-- 8. List the average number of tickets sold for each movie.

select count(tickets.ticketId) as "the average number of tickets sold for each movie", movies.name
from schedules
inner join tickets on schedules.scheduleId = tickets.scheduleId
right join movies on schedules.movieId = movies.movieId
group by movies.name;


select * from movies;
select * from tickets;

-- 9. List the highest number of tickets sold for a movie.


select count(tickets.ticketId) as "the MAX number of tickets sold for each movie"
from schedules
inner join tickets on schedules.scheduleId = tickets.scheduleId
right join movies on schedules.movieId = movies.movieId
group by movies.name
order by count(tickets.ticketId) desc
limit 1;



-- 10. List the unreserved seats for Joker.

-- step 1. We get the reservation id for Joker movie.
select reservations.reservationId
from schedules
inner join reservations on reservations.scheduleId = schedules.scheduleId
inner join  movies on schedules.movieId = movies.movieId
where movies.name = "Joker";

select * from reservations;
select * from schedules;
select * from movies;
-- step 2. We get the reserved seats for Joker. (get seat id for reservationId of Joker)

select seatId 
from reservation_seat
where reservationId in 
	(select reservations.reservationId
	from schedules
	inner join reservations on reservations.scheduleId = schedules.scheduleId
	inner join  movies on schedules.movieId = movies.movieId
	where movies.name = "Joker"
);

-- step 3. We get all the seats that are not reserved for Joker;

select seats.row, number 
from seats
where seatId not in (
	select seatId 
	from reservation_seat
	where reservationId in 
		(select reservations.reservationId
		from schedules
		inner join reservations on reservations.scheduleId = schedules.scheduleId
		inner join  movies on schedules.movieId = movies.movieId
		where movies.name = "Joker")
	
);
