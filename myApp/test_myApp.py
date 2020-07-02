import unittest
import myApp


class Test(unittest.TestCase):
    def setUp(self):
        self.app = myApp.app.test_client()

    def test_hello_world(self):
        res = self.app.get('/')
        self.assertEqual(200, res.status_code)  
        self.assertIn(res.data, b'Hello, World!')

    def test_health(self):
        res = self.app.get('/health')
        self.assertEqual(200, res.status_code)        

if __name__ == "__main__":
    unittest.main()