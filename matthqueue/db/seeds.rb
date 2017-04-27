# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

test = Institution.create({name: 'Test', secret: 'test', email_regex: 'test.com'})
test.password = 'test'

testProf = Account.create!(
  {name: 'Professor Test', email: 'p@test.com', professor: true, institution: test})
testProf.password = 'test'

testStudent = Account.create(
  {name: 'Student Test', email: 's@test.com', professor: false, institution: test})
testStudent.password = 'test'

testTA = Account.create(
  {name: 'TA Test', email: 'ta@test.com', professor: false, institution: test})
testTA.password = 'test'

testStudentTA = Account.create(
  {name: 'Student TA Test', email: 's-ta@test.com', professor: false, institution: test})
testStudentTA.password = 'test'

course1 = Course.create({
  name: 'Test Course 1', semester: '17sp', institution: test})

course2 = Course.create({
  name: 'Test Course 2', semester: '17sp', institution: test})

course3 = Course.create({
  name: 'Test Course 3', semester: '17sp', institution: test})

testProf.instructed_courses << course1
testTA.instructed_courses << course1
testStudent.enrolled_courses << course1
testStudentTA.enrolled_courses << course1

testProf.instructed_courses << course2
testStudentTA.instructed_courses << course2
testStudent.enrolled_courses << course2

testProf.instructed_courses << course3
testStudentTA.enrolled_courses << course3

start1 = Time.now.utc
end1 = start1 + (2 * 3600)

start0 = start1 - (7 * 24 * 3600)
end0 = start0 + (2 * 3600)

ohslot1_1 = OhTimeSlot.create({
  frequency: 'Weekly', start_time: start1, end_time: end1,
  course: course1})

start2 = Time.now.utc
end2 = start2 + (6 * 3600)

ohslot2_1 = OhTimeSlot.create({
  frequency: 'Weekly', start_time: start2, end_time: end2,
  course: course2})

start3 = Time.now.utc
end3 = start3 + (4 * 3600)

ohslot3_1 = OhTimeSlot.create({
  frequency: 'Daily', start_time: start3, end_time: end3,
  course: course3})

q0 = OhQueue.create({
  active: false, last_position: 2, start_time: start0, end_time: end0,
  oh_time_slot: ohslot1_1})

q1 = OhQueue.create({
  active: true, last_position: 6, start_time: start1, end_time: end1,
  oh_time_slot: ohslot1_1})

q2 = OhQueue.create({
  active: true, last_position: 3, start_time: start2, end_time: end2,
  oh_time_slot: ohslot2_1})

qstn0 = Question.create({
  title: 'Test Q 0', body: 'This is a test question.', oh_queue: q0,
  position: 1, student: testStudent, resolver: testTA, status: 'resolved',
  resolve_time: Time.now.utc + (4 * 60)}) 

qstn_u = Question.create!({
  title: 'Test Unresolved', body: 'This is unresolved.', oh_queue: q1,
  position: 4, student: testStudent, status: 'unresolved'})

qstn_ip = Question.create!({
  title: 'Test in-progress', body: 'This is in-progress.', oh_queue: q1,
  position: 5, student: testStudent, status: 'in-progress'})

qstn1 = Question.create({
  title: 'Test Q 1', body: 'This is a test question.', oh_queue: q1,
  position: 1, student: testStudent, resolver: testTA, status: 'resolved',
  resolve_time: Time.now.utc + (10 * 60)})

qstn2 = Question.create({
  title: 'Test Q 2', body: 'This is a test question.', oh_queue: q1,
  position: 2, student: testStudentTA, resolver: testTA, status: 'resolved',
  resolve_time: Time.now.utc + (15 * 60)})

qstn3 = Question.create({
  title: 'Test Q 3', body: 'This is a test question.', oh_queue: q1,
  position: 3, student: testStudent, resolver: testTA, status: 'resolved',
  resolve_time: Time.now.utc + (17 * 60)})

qstn4 = Question.create({
  title: 'Test Q 1', body: 'This is a test question.', oh_queue: q2,
  position: 1, student: testStudent, resolver: testStudentTA, status: 'resolved',
  resolve_time: Time.now.utc + (5 * 60)})

qstn5 = Question.create({
  title: 'Test Q 2', body: 'This is a test question.', oh_queue: q2,
  position: 2, student: testStudent, resolver: testTA, status: 'in-progress'})
