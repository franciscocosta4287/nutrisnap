import random
from PIL import Image


def process_image(image_file):
    image_file.seek(0)

    try:
        img = Image.open(image_file)
        img.load()  # força carregamento real da imagem
    except Exception as e:
        raise ValueError("Arquivo inválido ou não é uma imagem válida")

    image_file.seek(0)

    return {
        "calories": random.randint(300, 800),
        "protein": random.randint(10, 40),
        "carbs": random.randint(30, 90),
        "fats": random.randint(5, 30),
    }