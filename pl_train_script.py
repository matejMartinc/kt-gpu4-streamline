import torch
from torch.nn import functional as F
from torch.utils.data import DataLoader, TensorDataset
import pytorch_lightning as pl
from pytorch_lightning import Trainer
from pytorch_lightning.loggers import WandbLogger  # Import WandbLogger

class SimpleNN(pl.LightningModule):
    def __init__(self):
        super().__init__()
        self.layer1 = torch.nn.Linear(28 * 28, 128)
        self.layer2 = torch.nn.Linear(128, 10)

    def forward(self, x):
        x = x.view(x.size(0), -1)
        x = F.relu(self.layer1(x))
        x = F.log_softmax(self.layer2(x), dim=1)
        return x

    def training_step(self, batch, batch_idx):
        x, y = batch
        logits = self(x)
        loss = F.nll_loss(logits, y)
        self.log('train_loss', loss)  # Log training loss
        return loss

    def configure_optimizers(self):
        return torch.optim.Adam(self.parameters(), lr=1e-3)

# Initialize WandbLogger
wandb_logger = WandbLogger(name='SimpleNN', project='pytorch_lightning')

x = torch.randn(1024, 1, 28, 28)
y = torch.randint(0, 10, (1024,))
dataset = TensorDataset(x, y)
train_loader = DataLoader(dataset, batch_size=32)

model = SimpleNN()

# Pass the logger to the Trainer
trainer = Trainer(max_epochs=10, devices=4, strategy='ddp', logger=wandb_logger)
trainer.fit(model, train_loader)
