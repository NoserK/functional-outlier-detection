import torch
import torch.nn as nn
import torchvision.models as models
from torchvision import datasets, transforms
from torch.utils.data import DataLoader

# Define the nested architecture
class NestedVGGResNet(nn.Module):
    def __init__(self, num_classes=2):
        super(NestedVGGResNet, self).__init__()
        # Load the pre-trained VGGNet model
        self.vgg = models.vgg16(pretrained=True)
        # Remove the last classification layer from VGG
        self.vgg = nn.Sequential(*list(self.vgg.children())[:-2])
        
        # Load the pre-trained ResNet model
        self.resnet = models.resnet50(pretrained=True)
        # Modify ResNet's input layer to accept the output from VGG
        self.resnet.conv1 = nn.Conv2d(512, 64, kernel_size=7, stride=2, padding=3, bias=False)
        
        # Replace the last fully connected layer of ResNet to match the number of classes
        self.resnet.fc = nn.Linear(self.resnet.fc.in_features, num_classes)

    def forward(self, x):
        x = self.vgg(x)
        x = self.resnet(x)
        return x

# Instantiate the model
model = NestedVGGResNet(num_classes=2)

# Define the data transformations
data_transforms = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])

# Load the dataset
data_path = '/Users/wangz0m/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train'
train_dataset = datasets.ImageFolder(root=data_path, transform=data_transforms)
train_loader = DataLoader(train_dataset, batch_size=32, shuffle=True)

# Example forward pass
for inputs, labels in train_loader:
    outputs = model(inputs)
    print(outputs.shape)
    break
