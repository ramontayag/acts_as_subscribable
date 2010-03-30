def mock_user(stubs={})
	stubs[:login] ||= "chongo"
	mock_model(User, stubs)
end
