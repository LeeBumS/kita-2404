from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, DateField, SubmitField, PasswordField, BooleanField
from wtforms.validators import DataRequired, Length


class TaskForm(FlaskForm):
    title = StringField("제목", validators=[DataRequired()])
    contents = TextAreaField("내용", validators=[DataRequired()])
    due_date = DateField("마감일", format="%Y-%m-%d", validators=[DataRequired()])
    submit = SubmitField('Add Task')

class LoginForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Login')

class RegistrationForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired(), Length(min=4, max=25)])
    password = PasswordField('Password', validators=[DataRequired(), Length(min=6)])
    is_admin = BooleanField('Is Admin')
    submit = SubmitField('Register')